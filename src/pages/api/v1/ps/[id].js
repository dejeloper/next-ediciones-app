import { executeQuery } from "../../config/db";
import handlerResponseGet from "../../utils/handleResponse";

const ps = async (req, res) => {
  const { id } = req.query

  const result = await executeQuery({
    query: 'SELECT * FROM Ps WHERE Id = ?',
    values: [id],
  });

  const { code, response } = handlerResponseGet(result, "Carga Completa", "Error al Consultar los Ps");

  return res.status(code).json(response);
}

export default ps; 