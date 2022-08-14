import { executeQuery } from "../config/db";

export default async function handlerErrorSQL(error, errorMessage, endpoint) {

  if (error.sqlMessage) {
    const message = `${errorMessage}: ${error.sqlMessage}`;
    await saveLogErrorApi(message, endpoint);

    return {
      code: 200,
      response: {
        data: null,
        status: false,
        message: errorMessage
      }
    }
  }

  const message = `${errorMessage}: ${error}`;
  await saveLogErrorApi(message, endpoint);

  return {
    code: 200,
    response: {
      data: null,
      status: false,
      message: errorMessage
    }
  }

}

const saveLogErrorApi = async (message, endpoint) => {
  const { collection, method, action, Params } = endpoint;

  const result = await executeQuery({
    query: 'INSERT INTO LogError(`Message`, `Collection`, `Method`, `Type`, `Action`, `Params`) VALUES(?, ?, ?, ?, ?, ?)',
    values: [message, collection, method, 'Api', action, Params],
  });
}