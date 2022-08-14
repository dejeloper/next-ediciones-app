import { createPool } from "mysql2/promise";

const pool = createPool({
  host: process.env.MYSQL_HOST,
  port: process.env.MYSQL_PORT,
  database: process.env.MYSQL_DATABASE,
  user: process.env.MYSQL_USER,
  password: process.env.MYSQL_PASSWORD
});

const executeQuery = async ({ query, values }) => {
  try {
    const [rows] = await pool.query(query, values);

    let result = {
      rows,
      count: rows.length
    };

    return result;
  } catch (error) {
    return { error };
  }
}

export { executeQuery }