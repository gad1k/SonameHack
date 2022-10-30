import json
import os
import psycopg2

from datetime import datetime


def get_creds(name):
    with open("../config/cfg_02_creds.json", mode="r", encoding="utf-8") as data:
        return json.load(data).get(name)


def get_meta(name):
    with open("../config/cfg_03_meta.json", mode="r", encoding="utf-8") as data:
        return json.load(data).get(name)


def init_tables():
    return {
        "features": list(),
        "tags": list(),
        "points": list(),
        "nearby": list(),
        "weather": list(),
        "vehicles": list(),
        "vehicle_participants": list(),
        "vehicle_violations": list(),
        "participants": list(),
        "violations": list(),
        "road_conditions": list(),
        "participant_categories": list()
    }


def parse_file(file, tabs):
    origin_file = file.name.split("/")[-1]
    collection = json.load(file)

    for feature in collection.pop("features"):
        vehicle_stack = ["violations", tabs["vehicle_violations"], "participants", tabs["vehicle_participants"]]
        participant_stack = ["violations", tabs["violations"]]

        feature = feature.pop("properties")
        key = feature.get("id")

        fill_table(tabs["tags"], feature.pop("tags"), [key])
        fill_table(tabs["nearby"], feature.pop("nearby"), [key])
        fill_table(tabs["weather"], feature.pop("weather"), [key])
        fill_table(tabs["vehicles"], feature.pop("vehicles"), [key], vehicle_stack)
        fill_table(tabs["participants"], feature.pop("participants"), [key], participant_stack)
        fill_table(tabs["road_conditions"], feature.pop("road_conditions"), [key])
        fill_table(tabs["participant_categories"], feature.pop("participant_categories"), [key])

        tabs["points"].append([key, *feature.pop("point").values()])
        tabs["features"].append([*feature.values(), origin_file])


def fill_table(table, data, keys, stack=None):
    stack_table, stack_data = None, None

    if stack is not None and len(stack) != 0:
        stack_table, stack_data = stack.pop(), stack.pop()

    for seq_num, row in enumerate(data, start=1):
        if stack_table is not None:
            fill_table(stack_table, row.pop(stack_data), [*keys, seq_num], stack.copy())

        if isinstance(row, str):
            table.append([*keys, seq_num, row])
        else:
            table.append([*keys, seq_num, *row.values()])


def upload_file(tabs, cursor):
    for table, data in tabs.items():
        print(f"   {datetime.now()} :: {table}")
        upload_table(table, data, cursor)


def upload_table(table, data, cursor):
    query = get_meta("tables")[table]["query"]

    for row in data:
        try:
            if len(row) == 12 and table == "features":
                row.insert(3, None)

            cursor.execute(query, tuple(row))
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
    base_dir = get_meta("base_dir")
    files = [files for files in os.listdir(base_dir) if files != ".gitkeep"]

    with psycopg2.connect(**creds) as conn:
        try:
            with conn.cursor() as cur:
                for file in files:
                    with open(f"{base_dir}{file}", mode="r", encoding="utf-8") as json_data:
                        table_collection = init_tables()
                        parse_file(json_data, table_collection)
                        print(file)
                        upload_file(table_collection, cur)
                        conn.commit()
        except Exception as ex:
            conn.rollback()
            show_error(ex)


initial_file_upload()
