import { executeQuery } from '../../config/db';
import handlerResponseGet from "../../utils/handleResponse";

const loginHandler = async (req, res) => {
  const { user, pass } = req.body;

  if (user === "" || pass === "") {
    return res.status(400).json({
      status: false,
      message: process.env.LABEL_LOGIN_REQUIRED_USER_PASS,
    });
  };

  const endpoint = {
    collection: 'users',
    method: req.method,
    action: 'login',
    params: {
      user,
      pass
    }
  };

  const result = await executeQuery({
    query: 'SELECT * FROM Users WHERE User = ? AND Pass = ?',
    values: [user, pass],
  });

  const { code, response } = await handlerResponseGet(result, "Ok", process.env.LABEL_LOGIN_ERROR_INVALID_USER_PASS, endpoint);

  return res.status(code).json(response);
};

export default loginHandler;
