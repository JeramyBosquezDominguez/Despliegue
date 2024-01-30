# Nombre del stack
nombreStack="pilaJeramy2"

# Comando para eliminar el stack
aws cloudformation delete-stack --stack-name $nombreStack

aws cloudformation wait stack-delete-complete --stack-name $nombreStack

echo "Stack eliminado."
