# Nombre stack
nombreStack="pilaJeramy2"

# Nombre del archivo YAML que contiene la plantilla CloudFormation
template_file="main.yml"

# Comando para crear el stack
aws cloudformation create-stack \
    --stack-name $nombreStack \
    --template-body file://$template_file \
    $parameters

aws cloudformation wait stack-create-complete --stack-name $nombreStack

echo "Desplegado."