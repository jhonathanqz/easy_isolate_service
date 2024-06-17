<h1 align="center">Isolate Service</h1>

<p align="center">
  <a href="#dart-sobre">Sobre</a> &#xa0; | &#xa0; 
  <a href="#checkered_flag-">Como usar? </a> &#xa0; | &#xa0;
  <a href="#memo-licença">Licença</a> &#xa0; | &#xa0;
  <a href="https://github.com/jhonathanqz" target="_blank">Autor</a>
</p>

<br>

## :dart: Sobre

Package para facilitar o uso e integração de funções com Isolate.

## :checkered_flag: Como usar?

Adicione o plugin `easy_isolate_service` em seu arquivo `pubspec.yaml`, localizado na raíz do seu projeto.

```bash
easy_isolate_service: any
```

Após adicionar como dependência do projeto, você pode chamar os diferentes tipos implementados. Exemplo:

```bash
final result = await IsolateService.instance.spawn<String>((SendPort port){
final decode = jsonDecode(value);
port.send(value);
});
```

O valor da variável `result` será o resultado da conversão da função `jsonDecode`.

##### E qual a diferença ou qual a vantagem dessa implementação?

Ele fez esse processamento em uma outra thread, assim sem impactar a thread principal do aplicativo, e evitando que o usuário tenha a experiência de "gargalos".

## :memo: Licença

Este projeto está sob licença MIT. Veja o arquivo [LICENSE](LICENSE.md) para mais detalhes.

<table>
  <tr>
    <td align="center"><a href="https://github.com/jhonathanqz"><img src="https://avatars.githubusercontent.com/u/74057391?s=96&v=4" width="100px;" alt=""/><br /><sub><b>Jhonathan C. Queiroz</b></sub></a><br /> <a href="https://github.com/jhonathanqz" title="Autor">😎</a></td>
  </tr>
  
</table>

Feito por <a href="https://github.com/jhonathanqz" target="_blank">Jhonathan Queiroz</a>

&#xa0;

<a href="#top">Voltar para o topo</a>
