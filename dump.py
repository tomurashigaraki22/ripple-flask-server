from extensions.extensions import get_db_connection
import datetime

def dump_table_structure(cursor, table_name):
    """Get table creation SQL"""
    cursor.execute(f"SHOW CREATE TABLE {table_name}")
    return cursor.fetchone()['Create Table'] + ";\n\n"

def dump_table_data(cursor, table_name):
    """Get table data as INSERT statements"""
    cursor.execute(f"SELECT * FROM {table_name}")
    rows = cursor.fetchall()
    
    if not rows:
        return ""
        
    # Get column names
    columns = rows[0].keys()
    
    inserts = []
    for row in rows:
        values = []
        for column in columns:
            value = row[column]
            if value is None:
                values.append('NULL')
            elif isinstance(value, (int, float)):
                values.append(str(value))
            elif isinstance(value, (datetime.date, datetime.datetime)):
                values.append(f"'{value.strftime('%Y-%m-%d %H:%M:%S')}'")
            else:
                # Escape single quotes in strings
                values.append(f"'{str(value).replace('\'', '\'\'')}'")
                
        inserts.append(f"({', '.join(values)})")
    
    if inserts:
        columns_str = ', '.join(f"`{col}`" for col in columns)
        values_str = ',\n'.join(inserts)
        return f"INSERT INTO `{table_name}` ({columns_str}) VALUES\n{values_str};\n\n"
    
    return ""

def main():
    conn = get_db_connection()
    if not conn:
        print("Failed to connect to database")
        return
        
    cursor = conn.cursor()
    
    # Get all tables
    cursor.execute("SHOW TABLES")
    tables_result = cursor.fetchall()
    # Fix: Get the first value from each dictionary in the results
    tables = [list(table.values())[0] for table in tables_result]
    
    # Create output file
    timestamp = datetime.datetime.now().strftime('%Y%m%d_%H%M%S')
    filename = f'database_dump_{timestamp}.sql'
    
    with open(filename, 'w') as f:
        # Write header
        f.write("-- RippleBids Database Dump\n")
        f.write(f"-- Generated: {datetime.datetime.now()}\n\n")
        
        # Set character set
        f.write("SET NAMES utf8mb4;\n")
        f.write("SET FOREIGN_KEY_CHECKS = 0;\n\n")
        
        # Dump each table
        for table in tables:
            f.write(f"-- Table structure for {table}\n")
            f.write("DROP TABLE IF EXISTS `" + table + "`;\n")
            f.write(dump_table_structure(cursor, table))
            
            f.write(f"-- Data for {table}\n")
            f.write(dump_table_data(cursor, table))
            f.write("\n")
        
        # Reset settings
        f.write("SET FOREIGN_KEY_CHECKS = 1;\n")
    
    cursor.close()
    conn.close()
    
    print(f"Database dump created: {filename}")

if __name__ == "__main__":
    main()