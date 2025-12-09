# Tectonic - Un Cyber Range Académico
[![Regression Tests](https://github.com/GSI-Fing-Udelar/tectonic/actions/workflows/test.yml/badge.svg)](https://github.com/GSI-Fing-Udelar/tectonic/actions/workflows/test.yml)

## Resumen
Tectonic es un cyber range diseñado para proporcionar escenarios realistas de ciberseguridad para educación y entrenamiento a través del despliegue de redes, sistemas y aplicaciones que pueden ser utilizados para entrenar a los usuarios en temas de ciberseguridad. Sus funcionalidades clave incluyen configuraciones de red personalizables, monitoreo en tiempo real y simulaciones de ataques automatizados.

Incorpora herramientas existentes del enfoque de infraestructura como código (IaC), lo que permite la especificación de todos los componentes de  un escenario de ciberseguridad de manera declarativa. Esta especificación se realiza en un lenguaje de alto nivel que puede ser interpretado y permite la generación automática de escenarios en la plataforma subyacente del laboratorio. Las descripciones declarativas de los escenarios hacen que sean fáciles de versionar, mantener y compartir, facilitando la colaboración con otras instituciones y laboratorios de este tipo.

La siguiente figura ilustra varios componentes de la solución de cyber range, las tecnologías utilizadas en la implementación y los diferentes casos de uso llevados a cabo por los usuarios estudiantes e instructores. Los componentes se organizan en cinco capas, cada una cumpliendo una función particular en el funcionamiento de la plataforma.

<p align="center">
    <img src="https://raw.githubusercontent.com/GSI-Fing-Udelar/tectonic/refs/heads/main/docs/architecture.png" width="500">
</p>

La infraestructura subyacente constituye la infraestructura del mundo real sobre la cual se despliegan los sistemas y redes que forman la base de un escenario particular. Actualmente se soportan despliegues en la nube de AWS o en las propias instalaciones (on-premises) utilizando Libvirt, con más planeados a futuro.

Para lograr el despliegue de la infraestructura de manera automatizada,se utilizan herramientas de \textit{Infraestructura como Código} (IaC), como Packer, Terraform y Ansible. Estas herramientas gestionan los recursos a desplegar y las configuraciones a aplicarles. Los playbooks de Ansible, en particular, se utilizan ampliamente para la configuración.

Un componente de Python orquesta estas herramientas y gestiona el ciclo de vida de los escenarios, incluyendo su despliegue, eliminación, encendido, apagado y listado de información. Los escenarios en sí mismos se describen mediante una especificación que permite a los usuarios declarar varios aspectos, como las máquinas a desplegar, las redes utilizadas para conectarlas y las configuraciones a aplicar a las máquinas, entre otros.

## Instrucciones de Instalación
Los siguientes son los requisitos para ejecutar Tectonic:

- SO: Linux o Mac OS
- Python y pip: versión 3.10 o superior.
- Herramientas IaC: Terraform y Packer
- Plataformas base: Libvirt o Docker
- Credenciales de AWS y AWS CLI (para despliegue en AWS)


Por favor, consulta las [instrucciones detalladas](https://github.com/GSI-Fing-Udelar/tectonic/blob/main/docs/installation.md) para más
información.

### Módulo de Python de Tectonic

Puedes instalar este módulo usando el siguiente comando (preferiblemente dentro de un [entorno virtual](https://packaging.python.org/en/latest/guides/installing-using-pip-and-virtual-environments/#create-and-use-virtual-environments)):

```bash
python3 -m pip install tectonic-cyberrange
```


## Tectonic Configuration File
Tectonic behavior can be configured using an ini file with a `config` section. You can find an example configuration file with the default values [here](https://github.com/GSI-Fing-Udelar/tectonic/blob/main/tectonic.ini). Please see the [ini file documentation](https://github.com/GSI-Fing-Udelar/tectonic/blob/main/docs/ini_config.md) for details on the available options.


## Lab Configuration
The lab configuration is divided in two: a **scenario specification** that holds a static description of the lab that can be shared and reused, and information specific to a particular **lab edition** that defines things such as number of instances to deploy, public SSH keys for the teachers, etc.

The scenario specification consists of the following resources:

* A scenario description file in YAML syntax (required).
* Ansible playbooks for *base image* installation and *after-clone*
  configurations, and optional files in the `ansible` directory.
* Elastic and Kibana policies and resources, in the `elastic`
  directory, if using elastic for evaluation.
* SSH public keys for admin access to the machines in the `ssh`
  directory.

The lab edition file 

Please check the [description documentation](https://github.com/GSI-Fing-Udelar/tectonic/blob/main/docs/description.md) for more details. The [examples](https://github.com/GSI-Fing-Udelar/tectonic/blob/main/examples/) directory contains some example scenarios.

## Terraform state syncronization
Terraform states are stored locally by default. It is possible to store them in a Gitlab repo (see `gitlab_backend_url` option in the [ini file configuration](https://github.com/GSI-Fing-Udelar/tectonic/blob/main/docs/ini_config.md)). It is necessary to have Maintainer privileges on this repo and a GitLab access token. There are two types of access token: personal or project-based. If the latter is used, it must be associated with the project where the states are stored.

## Running Tectonic

To deploy a scenario run:
```
tectonic -c <ini_conf_file> <lab_edition_file> create-images
tectonic -c <ini_conf_file> <lab_edition_file> deploy
```

To destroy a scenario use the `destroy` command. 

See `tectonic --help` for a full list of options, and `tectonic
<command> -h` for help on individual commands.

## Access the Cyber Range

Access is via SSH and will depend on the type of platform used. See the [remote access](./docs/remote_access.md) documentation for more details.

## Disclaimer About Platforms

Tectonic provides support for scenario deployments using Docker as the base platform. However, it is important to note that using Docker as base platform in production environments is not recommended since Tectonic deploys containers in privileged mode. This means that when a user has root access within a container, they can also gain root access to the host system, which can create significant security issues. Therefore, caution is crucial when using Docker as a base platform, especially in scenarios involving attacks. It is advisable to utilize Docker primarily for the generation and testing of new scenarios. For production environments, we recommend to utilize Libvirt or AWS as base platform, both of which are fully supported by Tectonic.

The Elastic and Caldera services on the Docker platform for Windows and macOS are not supported.

## Authors

Tectonic was created by [Grupo de Seguridad
Informática](https://www.fing.edu.uy/inco/grupos/gsi) of [Universidad
de la República Uruguay](https://udelar.edu.uy/).

Please contact us at <tectonic@fing.edu.uy>.

See more of our project at [Tectonic: An Academic Cyber Range](https://www.fing.edu.uy/inco/proyectos/tectonic).

## License

Tectonic is licensed under the GNU General Public License v3.0 or
later. See LICENSE to see the full text.
