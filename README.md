# Pool Check
Este proyecto consiste en la aplicación móvil “Pool Check” para optimizar el mantenimiento de piscinas mediante los niveles de pH y cloro. Desarrollada con Flutter, un framework de Google para construir aplicaciones nativas, la aplicación se basa en sensores conectados a Fiware, una plataforma de herramientas para Internet de las Cosas, a través de Bluetooth y WiFi. Esta estructura permite a los usuarios monitorizar estos niveles en tiempo real y recibir recomendaciones para el mantenimiento adecuado.

El sistema incluye sensores de pH y cloro, un Arduino, un ESP-01 y un módulo HC-05 para la transmisión de datos. Además, gracias a STH-Comet, se dispone de una base de datos temporal que facilita la creación de gráficas para la prevención de futuros problemas. Para gestionar la información de los sensores, se utiliza un servidor local (en este caso mi propio ordenador) con Fiware instalado, administrando los datos mediante contenedores en Docker Desktop.

El proyecto está orientado a satisfacer las necesidades y requisitos de los usuarios, estableciendo objetivos claros para garantizar un producto eficiente y útil.

Palabras clave: Internet de las Cosas, cloro, pH, Arduino, HC-05, ESP-01, sensores
