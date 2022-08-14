import handlerErrorSQL from "./handlerErrors";

export default async function handlerResponseGet(result, successMessage, errorMessage, endpoint) {
  if (result.error) {
    return await handlerErrorSQL(result.error, errorMessage, endpoint);
  }

  if (result.count == 0) {
    return {
      code: 200,
      response: { status: false, data: result, message: errorMessage }
    }
  }

  return {
    code: 200,
    response: { status: true, data: result, message: successMessage }
  }
}

