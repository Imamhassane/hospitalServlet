const alerts  = document.getElementById("error");
const success  = document.getElementById("success");
const openModal  = document.getElementById("openModal");
const infoClient  = document.getElementById("info-client");
const update  = document.getElementsByClassName("update");
const edit = document.getElementsByClassName("edit");
const nonButton= document.getElementsByClassName("non-button");
const deleteButton = document.getElementsByClassName("delete");
const removeItemModal  = document.getElementsByClassName("remove-item");
const searchResult = document.getElementsByClassName("search-result");
const searchInput = document.getElementById("search-input");
const tittle = document.getElementById("tittle");
const tittleVide = document.getElementById("tittleVide");
const hiddenTr = document.getElementById("hiddenTr");

if(alerts){
    setTimeout(() => { alerts.style.display = "none"; }, 3000);
}
if(success){
    setTimeout(() => { success.style.display = "none"; }, 3000);
}
if (openModal){
    openModal.addEventListener("click",()=>{
        infoClient.classList.add("open");
        document.body.style.overflowY = "hidden"
    });

}
if (edit){
    for (let i = 0; i < edit.length; i++) {
        let button = edit[i];
        button.addEventListener("click" , ()=>{
            document.body.style.overflowY = "hidden";
            update[i].classList.add("open");

            if (localStorage.getItem("emailexist")){
                let val ;
                if (button.classList.contains("Sedit")){
                    val = nomClass[i].value;
                }else{
                    val = emailClass[i].value;
                }
                console.log(val);
                localStorage.setItem("emailexist", val);
            }
        });
        deleteButton[i].addEventListener("click",()=>{
            removeItemModal[i].classList.add("open");
            nonButton[i].addEventListener("click",()=>{
                removeItemModal[i].classList.remove("open");
            })
        });

    }
}

document.onclick = function(e){
    if(e.target.id === 'info-client' && e.target.id !== 'openModal'
        || e.target.className === "update open"
        ||  e.target.className === "remove-item open"
    )
    {
        infoClient.classList.remove("open");
        for (let i = 0; i < update.length; i++) {
            update[i].classList.remove("open");
            removeItemModal[i].classList.remove("open");
        }
        document.body.style.overflowY = "";
        localStorage.setItem("emailexist",null)
    }

};
function checkItems() {
    let count = 0;
    let searchVal = searchInput.value.toLowerCase();
    for (let i = 0; i < searchResult.length; i++) {
        let result = searchResult[i];
        let resultvalue = searchResult[i].getAttribute("value").toLowerCase();

        let nom = searchResult[i].getAttribute("nom");
        nom !== null ? nom = nom.toLowerCase() : nom = "²";
        let prenom = searchResult[i].getAttribute("prenom");
        prenom !== null ? prenom = prenom.toLowerCase() : prenom = "²";

        if (resultvalue.includes(searchVal) || nom.includes(searchVal) || prenom.includes(searchVal)){
            result.style.display = "table-row";
            tittleVide.classList.remove("print");
            tittle.classList.add("print");
            hiddenTr.classList.add("print");
            count ++;
        }else{
            result.style.display = "none";
        }
        if (count === 0){
            tittleVide.classList.add("print");
            tittle.classList.remove("print");
            hiddenTr.classList.remove("print")
        }

    }
}