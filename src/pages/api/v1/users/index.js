import { executeQuery } from "../../config/db";
import handlerResponseGet from "../../utils/handleResponse";

export default async function index(req, res) {
  const endpoint = {
    collection: 'users',
    method: req.method,
    action: 'index',
    Params: "{}"
  };

  const result = await executeQuery({
    query: 'SELECT * FROM Users',
    values: [],
  });

  const { code, response } = await handlerResponseGet(result, "Ok", process.env.LABEL_USERS_ERROR_GET_ALL_USERS, endpoint);

  return res.status(code).json(response);
}
