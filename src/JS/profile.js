nome = sessionStorage.nome
email = sessionStorage.email
endereco = sessionStorage.endereco
rg = sessionStorage.rg
dt_nasc = sessionStorage.dt_nasc

function exibe() {
    //     if (sessionStorage.nome == null || sessionStorage.email == null) {
    //     window.location.href = "../HTML/index.html"

    // }
    let info = document.getElementById("info")
    info.innerHTML += `
    
<div class="row ">
      <div class="row">
        <div class="col">
          <p>foto perfil</p>
        </div>
        <div class="col">
          <h3>nome</h3>
        </div>
        <div class="col">
          <h3>email</h3>
        </div>
        <div class="col">
          <h3>endereco</h3>
        </div>
        
        <div class="col">
          <h3>data de nascimento</h3>
        </div>
      </div>

      <div class="row">
        <div class="col">
        </div>
        <div class="col">
          <h3>${nome}</h3>
        </div>
        <div class="col">
          <h3>${email}</h3>
        </div>
        <div class="col">
          <h3>${endereco}</h3>
          
        </div>
        <div class="col">
          
          <h3>${dt_nasc}</h3>
        </div>
</div>
`
}

function deletar() {

    sessionStorage.clear()
    // sessionStorage.removeItem(nome)
    // sessionStorage.removeItem(email)
    // sessionStorage.removeItem(endereco)
    // sessionStorage.removeItem(rg)
    // sessionStorage.removeItem(dt_nasc)
    console.log(nome)
    console.log(email)
    console.log(endereco)
    console.log(rg)
    console.log(dt_nasc)
    window.location.reload();
}

function atualizar() {
    sessionStorage.nome = nome
    sessionStorage.email = email
    sessionStorage.endereco = endereco
    sessionStorage.rg = rg
    sessionStorage.dt_nasc = dt_nasc
    window.location.href = "../HTML/atualizar.html"
}