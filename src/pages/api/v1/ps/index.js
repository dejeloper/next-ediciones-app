import { executeQuery } from "../../config/db";
import handlerResponseGet from "../../utils/handleResponse";

export default async function handler(req, res) {
  const result = await executeQuery({
    query: 'SELECT * FROM Ps',
    values: [],
  });

  const { code, response } = handlerResponseGet(result, "Carga Completa", "Error al Consultar los Ps");

  return res.status(code).json(response);
}
