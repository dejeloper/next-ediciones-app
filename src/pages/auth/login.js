import { useState } from "react";
import axios from "axios";

const Login = () => {
  const [credentials, setCredentials] = useState({
    email: "",
    pass: "",
  });

  const [messageLogin, setMessageLogin] = useState("");

  const [parameters, setParameters] = useState([]);

  const getParameter = async (name) => {
    const result = await axios.get(`/api/v1/parameters/${name}`);
    setParameters({
      ...parameters,
      [name]: result.data
    })
    return result;
  }

  const handleChange = (e) => {
    setCredentials({
      ...credentials,
      [e.target.name]: e.target.value,
    });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      setMessageLogin("");
      const result = await axios.post("/api/v1/auth/login", credentials);
      const { data, status, message } = result.data;
      console.log({ data, status, message });
      if (!status) {
        setMessageLogin(message);
        return false;
      }
      setMessageLogin("Ok");
    } catch (err) {
      if (err.response) {
        setMessageLogin(err.response.data.message);
      } else {
        setMessageLogin(`Error: ${err.message}`);
      }
    }
  };

  getParameter('current_language'); // current_language

  return (
    <>
      <section className="h-screen">
        <div className="px-6 h-full text-gray-800">
          <div className="flex justify-center items-center flex-wrap h-full g-6">
            <div className="ml-20 w-5/12 mb-12">
              <h1 className="text-3xl mb-3 mr-4">Inicio Sesión: {parameters['current_language']}</h1>
              <form onSubmit={handleSubmit}>
                <div className="mb-6">
                  <input
                    type="text"
                    className="form-control block w-full px-4 py-2 text-xl font-normal text-gray-700 bg-white bg-clip-padding border border-solid border-gray-300 rounded transition ease-in-out m-0 focus:text-gray-700 focus:bg-white focus:border-blue-600 focus:outline-none"
                    placeholder="User"
                    autoComplete="false"
                    name="user"
                    onChange={handleChange}
                  />
                </div>

                <div className="mb-6">
                  <input
                    type="password"
                    className="form-control block w-full px-4 py-2 text-xl font-normal text-gray-700 bg-white bg-clip-padding border border-solid border-gray-300 rounded transition ease-in-out m-0 focus:text-gray-700 focus:bg-white focus:border-blue-600 focus:outline-none"
                    placeholder="Password"
                    autoComplete="false"
                    name="pass"
                    onChange={handleChange}
                  />
                </div>

                <div className="text-center">
                  <button className="inline-block px-7 py-3 bg-blue-600 text-white font-medium text-sm leading-snug uppercase rounded shadow-md hover:bg-blue-700 hover:shadow-lg focus:bg-blue-700 focus:shadow-lg focus:outline-none focus:ring-0 active:bg-blue-800 active:shadow-lg transition duration-150 ease-in-out">
                    Login
                  </button>
                </div>
              </form>
              {messageLogin && (
                <div
                  className="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative mt-4 boxMessage"
                  role="alert">
                  <strong className="font-bold">Error: </strong>
                  <span className="block sm:inline">{messageLogin}</span>
                  <span
                    className="absolute top-0 bottom-0 right-0 px-4 py-3"
                    onClick={() => { setMessageLogin("") }}>
                    <svg
                      className="fill-current h-6 w-6 text-red-500"
                      role="button"
                      xmlns="http://www.w3.org/2000/svg"
                      viewBox="0 0 20 20">
                      <title>Close</title>
                      <path d="M14.348 14.849a1.2 1.2 0 0 1-1.697 0L10 11.819l-2.651 3.029a1.2 1.2 0 1 1-1.697-1.697l2.758-3.15-2.759-3.152a1.2 1.2 0 1 1 1.697-1.697L10 8.183l2.651-3.031a1.2 1.2 0 1 1 1.697 1.697l-2.758 3.152 2.758 3.15a1.2 1.2 0 0 1 0 1.698z" />
                    </svg>
                  </span>
                </div>
              )}
            </div>
          </div>
        </div>
      </section>
    </>
  );
}

export default Login;