import json
from datetime import datetime
from enum import Enum
from pathlib import Path

import psycopg2

CONFIG_DIR = Path("../config/")
DATA_DIR = Path("../data/")


class Table(Enum):
    FEATURES = "features"
    TAGS = "tags"
    POINTS = "points"
    NEARBY = "nearby"
    WEATHER = "weather"
    VEHICLES = "vehicles"
    VEHICLE_PARTICIPANTS = "vehicle_participants"
    VEHICLE_VIOLATIONS = "vehicle_violations"
    PARTICIPANTS = "participants"
    VIOLATIONS = "violations"
    ROAD_CONDITIONS = "road_conditions"
    PARTICIPANT_CATEGORIES = "participant_categories"


def get_creds(name):
    with CONFIG_DIR.joinpath("cfg_02_creds.json").open(encoding="utf-8") as data:
        return json.load(data).get(name)


def get_meta(name):
    with CONFIG_DIR.joinpath("cfg_03_meta.json").open(encoding="utf-8") as data:
        return json.load(data).get(name)


class Parser:
    """Class to parse a single car accident file."""
    def __init__(self, file_path):
        self.file_path = file_path
        self.tables = {table.value: [] for table in Table}

    def get_collection(self):
        """Get data from a file in json format."""
        with self.file_path.open(encoding="utf-8") as file:
            return json.load(file)

    def get_parsed_data(self):
        """Get parsed data."""
        for feature in self.get_collection().pop("features"):
            vehicle_stack = [Table.VIOLATIONS.value, self.tables[Table.VEHICLE_VIOLATIONS.value],
                             Table.PARTICIPANTS.value, self.tables[Table.VEHICLE_PARTICIPANTS.value]]
            participant_stack = [Table.VIOLATIONS.value, self.tables[Table.VIOLATIONS.value]]

            feature = feature.pop("properties")
            key = feature.get("id")

            self.fill_table(self.tables[Table.TAGS.value], feature.pop(Table.TAGS.value), [key])
            self.fill_table(self.tables[Table.NEARBY.value], feature.pop(Table.NEARBY.value), [key])
            self.fill_table(self.tables[Table.WEATHER.value], feature.pop(Table.WEATHER.value), [key])
            self.fill_table(self.tables[Table.VEHICLES.value], feature.pop(Table.VEHICLES.value), [key],
                            vehicle_stack)
            self.fill_table(self.tables[Table.PARTICIPANTS.value], feature.pop(Table.PARTICIPANTS.value), [key],
                            participant_stack)
            self.fill_table(self.tables[Table.ROAD_CONDITIONS.value], feature.pop(Table.ROAD_CONDITIONS.value), [key])
            self.fill_table(self.tables[Table.PARTICIPANT_CATEGORIES.value],
                            feature.pop(Table.PARTICIPANT_CATEGORIES.value),
                            [key])

            self.tables[Table.POINTS.value].append([key, *feature.pop("point").values()])
            self.tables[Table.FEATURES.value].append([*feature.values(), self.file_path.name])

        return self.tables

    def fill_table(self, table, data, keys, stack=None):
        stack_table, stack_data = None, None

        if stack is not None and stack:
            stack_table, stack_data = stack.pop(), stack.pop()

        for seq_num, row in enumerate(data, start=1):
            if stack_table is not None:
                self.fill_table(stack_table, row.pop(stack_data), [*keys, seq_num], stack.copy())

            if isinstance(row, str):
                table.append([*keys, seq_num, row])
            else:
                table.append([*keys, seq_num, *row.values()])


class Uploader:
    """Class to upload data into a db."""
    def __init__(self, cursor):
        self.cursor = cursor

    def upload_data(self, tables_data):
        for table, data in tables_data.items():
            print(f"   {datetime.now()} :: {table}")
            self.upload_data_into_table(table, data)

    def upload_data_into_table(self, table, data):
        query = get_meta("tables")[table]["query"]

        for row in data:
            try:
                if len(row) == 12 and table == Table.FEATURES.value:
                    row.insert(3, None)

                self.cursor.execute(query, tuple(row))
            except Exception as e:
                raise Exception(e, table, row)


def show_error(err):
    print("\n=================================================================\n")
    print("ERROR:", err.args[0])

    print("TABLE:", err.args[1], end="\n\n")

    print("COLUMNS:")

    for column in err.args[2]:
        print(f"   {str(len(str(column))).zfill(4)} => {column}")


def initial_file_upload():
    creds = get_creds("hackathon_hst")

    with psycopg2.connect(**creds) as conn:
        try:
            with conn.cursor() as cur:
                for file in DATA_DIR.glob("*.geojson"):
                    data = Parser(file).get_parsed_data()
                    Uploader(cur).upload_data(data)

                    conn.commit()
        except Exception as ex:
            conn.rollback()
            show_error(ex)


if __name__ == "__main__":
    initial_file_upload()
