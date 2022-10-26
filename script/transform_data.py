import json
import pg8000


def get_creds(name):
    with open("../config/creds.json", mode="r", encoding="utf-8") as data:
        return json.load(data).get(name)


def get_table_info(name):
    with open("../config/queries.json", mode="r", encoding="utf-8") as data:
        return json.load(data).get(name)


def upload_table(table_name, table_data, cursor):
    query = get_table_info(table_name)["query"]

    try:
        for row in table_data:
            values = [*row.values()]

            # if len(values) == 11:
            #     values.insert(3, None)

            cursor.execute(query, tuple(values))
    except Exception as e:
        raise Exception(row, e)


with open("../data/chukotskii-avtonomnyi-okrug.geojson", mode="r", encoding="utf-8") as json_file:
    collection = json.load(json_file)

    features = list()

    for f in collection.pop("features"):
        feature = f.pop("properties")

        feature.pop("tags")
        feature.pop("point")
        feature.pop("nearby")
        feature.pop("weather")
        feature.pop("vehicles")
        feature.pop("participants")
        feature.pop("road_conditions")
        feature.pop("participant_categories")

        features.append(feature)

    creds = get_creds("hackathon_hst")
    with pg8000.connect(**creds) as conn:
        try:
            with conn.cursor() as cur:
                upload_table("features", features, cur)
                conn.commit()
        except Exception as ex:
            conn.rollback()

            for k, v in ex.args[0].items():
                if isinstance(v, str):
                    print(f"'{k}': ({len(v)}) {v}")
                else:
                    print(f"'{k}': (XX) {v}")

            print("\n", ex.args[1])
