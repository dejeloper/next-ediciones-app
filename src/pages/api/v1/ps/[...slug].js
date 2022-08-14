
import { executeQuery } from "../../config/db";
import handlerResponseGet from "../../utils/handleResponse";

const ps = async (req, res) => {
  const id = req.query.slug[0];
  const store = req.query.slug[1];
  const storeId = req.query.slug[2];

  const result = await executeQuery({
    query: 'SELECT * FROM Ps WHERE Id = ?',
    values: [id],
  });

  const { code, response } = handlerResponseGet(result, `Carga Completa - Store: ${store} - ${storeId}`, "Error al Consultar los Ps",);

  return res.status(code).json(response);
  // return res.status(200).json(slug); 
}

export default ps; 