import { executeQuery } from "../../config/db";
import handlerResponseGet from "../../utils/handleResponse";

export default async function index(req, res) {
  const { name } = req.query;

  const result = await executeQuery({
    query: 'SELECT Value FROM Parameters WHERE Name = ? AND Enabled = ? LIMIT 1',
    values: [name, 1],
  });

  return res.status(200).json(result.rows[0]["Value"]);
}
