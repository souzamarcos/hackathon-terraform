# Tech Challenge Terraform
Repositório com a infraestrutura AWS do tech challenge da FIAP utilizando terraform.

# Repositórios relacionados
* [Aplicação](https://github.com/souzamarcos/tech-challenge-fast-food)
* [Infraestrutura Terraform](https://github.com/souzamarcos/tech-challenge-terraform)
* [Configuração do Kubernetes](https://github.com/souzamarcos/tech-challenge-kubernetes)
* [Lambda de Autenticação](https://github.com/souzamarcos/tech-challenge-authentication-lambda)

# Executando mudanças na infraestrutura
Basta abrir uma PR para a branch `main` com as novas alterações que o workflow `Terraform Plan` será executado. Caso o plano seja criado com sucesso, basta mergear a PR após aprovação de outro membro da equipe. O workflow `Terraform Apply` será executado assim que a PR for mergeada. Todo o processo do Terraform pode ser acompanhado pela página do [Terraform Cloud](https://app.terraform.io/app/souzamarcos/workspaces/terraform-github-actions).

# Revertendo mudanças na infraestrutura
Basta abrir outra PR e seguir os passos acimma. Se for necessário apagar tudo que foi criado basta entrar na página https://app.terraform.io/app/souzamarcos/workspaces/terraform-github-actions/settings/delete, clicar no botão `Queue Destroy Plan` e depois aplicar o plano criado para deletar todos os recursos criados anteriormente.
