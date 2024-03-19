# Hackathon Terraform
Repositório com a infraestrutura AWS do hackathon da FIAP utilizando terraform.

# Repositórios relacionados
* [Serviço de funcionários](https://github.com/souzamarcos/hackathon-ms-employee)
* [Serviço de entrada de ponto](https://github.com/souzamarcos/hackathon-ms-working-hours-entry)
* [Serviço de registro de ponto](https://github.com/souzamarcos/hackathon-ms-working-hours-registry)
* [Serviço de relatório](https://github.com/souzamarcos/hackathon-ms-report)
* [Infraestrutura Terraform](https://github.com/souzamarcos/hackathon-terraform)
* [Configuração do Kubernetes](https://github.com/souzamarcos/hackathon-kubernetes)

# Executando mudanças na infraestrutura
Basta abrir uma PR para a branch `main` com as novas alterações que o workflow `Terraform Plan` será executado. Caso o plano seja criado com sucesso, basta mergear a PR após aprovação de outro membro da equipe. O workflow `Terraform Apply` será executado assim que a PR for mergeada. Todo o processo do Terraform pode ser acompanhado pela página do [Terraform Cloud](https://app.terraform.io/app/souzamarcos/workspaces/hackathon-terraform).

# Revertendo mudanças na infraestrutura
Basta abrir outra PR e seguir os passos acimma. Se for necessário apagar tudo que foi criado basta entrar na página https://app.terraform.io/app/souzamarcos/workspaces/hackathon-terraform/settings/delete, clicar no botão `Queue Destroy Plan` e depois aplicar o plano criado para deletar todos os recursos criados anteriormente.
