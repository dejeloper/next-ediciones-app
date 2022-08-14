import Head from "next/head";

const Home = () => {
  return (
    <div className="app">
      <Head>
        <title>Avo</title>
        <meta name="description" content="Aplicación AVO" />
        <link rel="icon" href="/favicon.ico" />
      </Head>
      <main className="flex justify-center items-center border-solid border-2 border-black">
        <div className="bg-gray-50 w-full ">
          <div className="w-max-w-7xl mx-auto py-12 px-4 sm:px-6 lg:py-16 lg:px-8 lg:flex lg:items-center lg:justify-between border-solid border-2 border-black">
            <h2 className="text-3xl font-extrabold tracking-tight text-gray-900 sm:text-4xl">
              <span className="block">Avo</span>
              <span className="block text-blue-600">
                Empresa en construcción.
              </span>
            </h2>
            <div className="mt-8 flex lg:mt-0 lg:flex-shrink-0">
              <div className="inline-flex rounded-md shadow">
                <a
                  href="#"
                  className="inline-flex items-center justify-center px-5 py-3 border border-transparent text-base font-medium rounded-md text-white bg-blue-600 hover:bg-blue-700"
                >
                  Iniciar
                </a>
              </div>
              <div className="ml-3 inline-flex rounded-md shadow">
                <a
                  href="#"
                  className="inline-flex items-center justify-center px-5 py-3 border border-transparent text-base font-medium rounded-md text-blue-600 bg-white hover:bg-blue-50"
                >
                  Aprender más
                </a>
              </div>
            </div>
          </div>
        </div>
      </main>
    </div>
  );
};

export default Home;
