import subprocess

# Database connection details
DB_HOST = "blockcred-mvp-blockcred-582a.i.aivencloud.com"
DB_PORT = "26198"
DB_USER = "avnadmin"
DB_PASSWORD = "AVNS_bnytXLtrB-LEFtcjSg9"  # from your env
DB_NAME = "defaultdb"

# Output file
OUTPUT_FILE = "schema.sql"

try:
    # Run mysqldump with --no-data to only get schema
    result = subprocess.run(
        [
            "mysqldump",
            "-h", DB_HOST,
            "-P", DB_PORT,
            "-u", DB_USER,
            f"-p{DB_PASSWORD}",
            "--no-data",  # only schema
            DB_NAME
        ],
        capture_output=True,
        text=True,
        check=True
    )

    # Save schema to file
    with open(OUTPUT_FILE, "w") as f:
        f.write(result.stdout)

    print(f"✅ Schema exported successfully to {OUTPUT_FILE}. You can paste it into phpMyAdmin.")

except subprocess.CalledProcessError as e:
    print("❌ Error while exporting schema:")
    print(e.stderr)
