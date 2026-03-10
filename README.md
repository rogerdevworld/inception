<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inception 42 - rmarrero</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        :root {
            --bg-dark: #1e1e2e;
            --bg-card: #2a2a3c;
            --attr-global: #ff7b72;
            --sub-attr: #79c0ff;
            --detail: #d2a8ff;
            --value: #7ee787;
            --comment: #ffa657;
            --header-text: #e6edf3;
        }

        body {
            background-color: var(--bg-dark);
            color: var(--header-text);
            font-family: 'Courier New', Courier, monospace;
        }

        .code-container {
            background-color: rgba(30, 30, 46, 0.8);
            border-radius: 8px;
            padding: 20px;
            border: 1px solid #444;
        }

        .tag-global { color: var(--attr-global); }
        .tag-sub { color: var(--sub-attr); }
        .tag-detail { color: var(--detail); }
        .tag-value { color: var(--value); }
        .tag-comment { color: var(--comment); }

        .section-number {
            font-size: 4rem;
            opacity: 0.3;
            font-weight: bold;
            line-height: 1;
        }

        .diagram-container {
            background: #f0f0f0;
            color: #333;
            border-radius: 8px;
            padding: 1rem;
        }
    </style>
</head>
<body class="p-4 md:p-8">
    <header class="mb-12 border-b border-gray-700 pb-6">
        <h1 class="text-4xl font-bold mb-2">Proyecto Inception <span class="text-blue-400">42</span></h1>
        <p class="text-xl opacity-75">Guía de Referencia para <span class="underline decoration-blue-500">rmarrero</span></p>
    </header>

    <div class="grid grid-cols-1 lg:grid-cols-12 gap-8">
        
        <!-- COLUMNA IZQUIERDA: ESTRUCTURA Y DOCKER COMPOSE -->
        <div class="lg:col-span-7 space-y-12">
            
            <!-- Leyenda -->
            <section class="flex flex-wrap gap-4 text-xs font-bold uppercase tracking-wider">
                <span class="flex items-center gap-2"><div class="w-4 h-4" style="background: var(--attr-global)"></div> ATRIBUTOS GLOBALES</span>
                <span class="flex items-center gap-2"><div class="w-4 h-4" style="background: var(--sub-attr)"></div> SUB-ATRIBUTOS</span>
                <span class="flex items-center gap-2"><div class="w-4 h-4" style="background: var(--detail)"></div> DETALLES</span>
                <span class="flex items-center gap-2"><div class="w-4 h-4" style="background: var(--value)"></div> VALORES</span>
                <span class="flex items-center gap-2"><div class="w-4 h-4" style="background: var(--comment)"></div> COMENTARIOS</span>
            </section>

            <!-- 1. Estructura de Archivos -->
            <section class="relative">
                <div class="absolute right-0 top-0 section-number">1</div>
                <h2 class="text-2xl font-bold mb-4 border-l-4 border-blue-500 pl-4">Estructura de Directorios</h2>
                <div class="code-container">
                    <pre class="text-sm">
src/
├── <span class="tag-value">docker-compose.yml</span>
├── <span class="tag-value">.env</span>
└── requirements/
    ├── mariadb/
    │   ├── <span class="tag-detail">Dockerfile</span>
    │   ├── conf/ <span class="tag-comment"># Archivos de config (.cnf)</span>
    │   └── tools/ <span class="tag-comment"># Scripts (.sh)</span>
    ├── nginx/
    │   ├── <span class="tag-detail">Dockerfile</span>
    │   └── conf/ <span class="tag-comment"># TLS/SSL</span>
    └── wordpress/
        ├── <span class="tag-detail">Dockerfile</span>
        └── tools/ <span class="tag-comment"># Script para instalar WP-CLI</span>
                    </pre>
                </div>
            </section>

            <!-- 2. Services Section -->
            <section class="relative">
                <div class="absolute right-0 top-0 section-number">2</div>
                <h2 class="text-2xl font-bold mb-4 border-l-4 border-blue-500 pl-4">Docker Compose: Services</h2>
                <div class="code-container overflow-x-auto">
                    <pre class="text-sm">
<span class="tag-global">version:</span> <span class="tag-value">'3.8'</span>

<span class="tag-global">services:</span>
  <span class="tag-sub">service_name:</span>               <span class="tag-comment"># Ejemplo: wordpress</span>
    <span class="tag-detail">image:</span> <span class="tag-value">service_name</span>      <span class="tag-comment"># Debe ser igual al nombre del servicio</span>
    <span class="tag-detail">container_name:</span> <span class="tag-value">service_name</span>
    <span class="tag-detail">build:</span>
      <span class="tag-detail">context:</span> <span class="tag-value">./requirements/wordpress</span>
      <span class="tag-detail">dockerfile:</span> <span class="tag-value">Dockerfile</span>
    <span class="tag-detail">env_file:</span>
      - <span class="tag-value">.env</span>                   <span class="tag-comment"># Variables de entorno</span>
    <span class="tag-detail">ports:</span>
      - <span class="tag-value">"443:443"</span>              <span class="tag-comment"># Solo para Nginx</span>
    <span class="tag-detail">volumes:</span>
      - <span class="tag-value">"db_data:/var/lib/mysql"</span> <span class="tag-comment"># Persistencia</span>
    <span class="tag-detail">networks:</span>
      - <span class="tag-value">internal-net</span>
    <span class="tag-detail">restart:</span> <span class="tag-value">always</span>           <span class="tag-comment"># Recomendado para Inception</span>
                    </pre>
                </div>
            </section>

            <!-- 3. Volumes & Networks -->
            <section class="grid md:grid-cols-2 gap-4">
                <div class="relative">
                    <div class="absolute right-0 top-0 section-number">3</div>
                    <h2 class="text-xl font-bold mb-4 border-l-4 border-blue-500 pl-4">Volumes</h2>
                    <div class="code-container">
                        <pre class="text-xs">
<span class="tag-global">volumes:</span>
  <span class="tag-sub">db_data:</span>
    <span class="tag-detail">driver:</span> <span class="tag-value">local</span>
    <span class="tag-detail">driver_opts:</span>
      <span class="tag-detail">type:</span> <span class="tag-value">none</span>
      <span class="tag-detail">o:</span> <span class="tag-value">bind</span>
      <span class="tag-detail">device:</span> <span class="tag-value">${DATA_PATH}/db</span>
                        </pre>
                    </div>
                </div>
                <div class="relative">
                    <div class="absolute right-0 top-0 section-number">4</div>
                    <h2 class="text-xl font-bold mb-4 border-l-4 border-blue-500 pl-4">Networks</h2>
                    <div class="code-container">
                        <pre class="text-xs">
<span class="tag-global">networks:</span>
  <span class="tag-sub">internal-net:</span>
    <span class="tag-detail">driver:</span> <span class="tag-value">bridge</span>
                        </pre>
                    </div>
                </div>
            </section>
        </div>

        <!-- COLUMNA DERECHA: CONFIG Y DIAGRAMAS -->
        <div class="lg:col-span-5 space-y-8">
            
            <!-- 2.1 .env -->
            <section class="relative bg-gray-800 p-6 rounded-lg border border-purple-500">
                <div class="absolute right-4 top-2 text-3xl font-bold opacity-20">2.1</div>
                <h3 class="text-purple-400 font-bold mb-4">.env (Configuración)</h3>
                <div class="text-sm font-mono space-y-1">
                    <p class="text-gray-500"># --- DB CONFIG ---</p>
                    <p>SQL_DATABASE=inception_db</p>
                    <p>SQL_USER=<span class="text-yellow-400 font-bold">rmarrero</span></p>
                    <p>SQL_PASSWORD=12345</p>
                    <p>SQL_ROOT_PASSWORD=12345</p>
                    <p class="mt-4 text-gray-500"># --- SYSTEM ---</p>
                    <p>DOMAIN_NAME=<span class="text-yellow-400">rmarrero.42.fr</span></p>
                    <p>USER_DATA_PATH=/home/rmarrero/data</p>
                </div>
            </section>

            <!-- 2.2 Dockerfile -->
            <section class="relative bg-gray-800 p-6 rounded-lg border border-blue-500">
                <div class="absolute right-4 top-2 text-3xl font-bold opacity-20">2.2</div>
                <h3 class="text-blue-400 font-bold mb-4">Dockerfile (Debian Bullseye)</h3>
                <div class="text-xs font-mono space-y-1 bg-black p-4 rounded">
                    <p><span class="text-pink-500">FROM</span> debian:bullseye</p>
                    <p><span class="text-pink-500">RUN</span> apt-get update && apt-get install -y mariadb-server</p>
                    <p><span class="text-pink-500">COPY</span> ./tools/setup.sh /usr/local/bin/</p>
                    <p><span class="text-pink-500">EXPOSE</span> 3306</p>
                    <p><span class="text-pink-500">ENTRYPOINT</span> ["/usr/local/bin/setup.sh"]</p>
                </div>
            </section>

            <!-- Diagrama de Red -->
            <section class="diagram-container shadow-2xl">
                <h3 class="text-center font-bold text-gray-700 mb-4 uppercase">Esquema de Infraestructura</h3>
                <div class="flex flex-col items-center gap-4">
                    <!-- Web / WWW -->
                    <div class="flex flex-col items-center">
                        <div class="w-12 h-12 bg-blue-100 rounded-full flex items-center justify-center border-2 border-blue-400">🌐</div>
                        <span class="text-[10px] font-bold">Internet (443)</span>
                    </div>
                    
                    <div class="w-px h-8 bg-gray-400 border-dashed border"></div>

                    <!-- Host -->
                    <div class="w-full border-2 border-gray-400 rounded p-4 relative">
                        <span class="absolute -top-3 left-2 bg-white px-2 text-[10px] font-bold">COMPUTER HOST</span>
                        
                        <div class="bg-gray-300 p-4 rounded border border-gray-500">
                            <span class="text-[9px] font-bold uppercase block mb-2">Docker network (internal-net)</span>
                            
                            <div class="grid grid-cols-3 gap-2">
                                <div class="bg-white p-2 border border-gray-400 rounded flex flex-col items-center">
                                    <div class="text-lg">🗄️</div>
                                    <span class="text-[8px] font-bold">DB (3306)</span>
                                </div>
                                <div class="bg-white p-2 border border-gray-400 rounded flex flex-col items-center">
                                    <div class="text-lg">📝</div>
                                    <span class="text-[8px] font-bold text-center">WP + PHP (9000)</span>
                                </div>
                                <div class="bg-white p-2 border border-blue-400 rounded flex flex-col items-center shadow-md">
                                    <div class="text-lg">🛡️</div>
                                    <span class="text-[8px] font-bold">NGINX (443)</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Persistencia -->
                    <div class="flex gap-4 mt-2">
                        <div class="flex flex-col items-center">
                            <div class="w-10 h-10 bg-gray-200 border border-gray-400 rounded"></div>
                            <span class="text-[8px]">DB Volume</span>
                        </div>
                        <div class="flex flex-col items-center">
                            <div class="w-10 h-10 bg-gray-200 border border-gray-400 rounded"></div>
                            <span class="text-[8px]">Web Volume</span>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Script Bash -->
            <section class="bg-[#333] p-4 rounded border-l-8 border-yellow-500">
                <div class="text-xl font-bold text-gray-400">#! /bin/bash</div>
                <p class="text-[10px] mt-2 italic text-gray-300">"Conf: aquí va el script que crea usuarios de DB, descarga paquetes o configura WordPress por CLI..."</p>
            </section>

        </div>
    </div>

    <footer class="mt-16 pt-8 border-t border-gray-700 text-center text-gray-500 text-sm">
        <p>Inception Project - Final Submission Framework</p>
        <p class="mt-2 font-mono">Dev: rmarrero | School: 42</p>
    </footer>

    <script>
        // Animación simple de aparición
        document.addEventListener('DOMContentLoaded', () => {
            const sections = document.querySelectorAll('section');
            sections.forEach((s, i) => {
                s.style.opacity = '0';
                s.style.transform = 'translateY(20px)';
                s.style.transition = 'all 0.5s ease-out';
                setTimeout(() => {
                    s.style.opacity = '1';
                    s.style.transform = 'translateY(0)';
                }, i * 100);
            });
        });
    </script>
</body>
</html>