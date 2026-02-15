import os
import pandas as pd

def csv_to_parquet(csv_path):
    parquet_path = os.path.splitext(csv_path)[0] + ".parquet"

    if os.path.exists(parquet_path):
        print(f"Skipping (exists): {parquet_path}")
        return

    print(f"Converting: {csv_path}")

    df = pd.read_csv(csv_path)
    df.to_parquet(
        parquet_path,
        engine="pyarrow",
        compression="snappy",
        index=False
    )

    print(f"Created: {parquet_path}")

def main():
    for filename in os.listdir("."):
        if filename.lower().endswith(".csv") and os.path.isfile(filename):
            csv_to_parquet(filename)

if __name__ == "__main__":
    main()
