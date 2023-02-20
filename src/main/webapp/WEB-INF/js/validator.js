//Validation info personnelle


const formMedcin = document.getElementById('formMedcin');
const formService = document.getElementById('formService');
const formSpecialite = document.getElementById('formSpecialite');
const nom = document.getElementById('nom');
const serviceClass = document.getElementsByClassName('service');
const formServiceUpdate = document.getElementsByClassName('formService');
const formSpecialiteUpdate = document.getElementsByClassName('formSpecialite');
const formMedcinUpdate = document.getElementsByClassName('formMedcin');
const prenom = document.getElementById('prenom');
const salaire = document.getElementById('salaire');
const email = document.getElementById('email');
const password = document.getElementById('password');
const adresse = document.getElementById('adresse');
const naissance = document.getElementById('naissance');
const embauche = document.getElementById('embauche');
const specialite = document.getElementById('specialite');
const service = document.getElementById('service');
const emails = document.getElementsByClassName('allEmails');
//
const nomClass = document.getElementsByClassName('nom');
const prenomClass = document.getElementsByClassName('prenom');
const salaireClass = document.getElementsByClassName('salaire');
const emailClass = document.getElementsByClassName('email');
const passwordClass = document.getElementsByClassName('password');
const adresseClass = document.getElementsByClassName('adresse');
const naissanceClass = document.getElementsByClassName('naissance');
const embaucheClass = document.getElementsByClassName('embauche');
const specialiteClass = document.getElementsByClassName('specialite');
let isVerify = [];
//Functions-------------------------------------------------------------
function showError(input, message) {//Afficher les messages d'erreur
    const formControl = input.parentElement;
    formControl.classList.add("error");
    formControl.classList.remove("success");
    isVerify.push(false);

    const small = formControl.querySelector('small');
    small.innerText = message;
}
//
function showSuccess(input) {
    const formControl = input.parentElement;
    formControl.classList.add("success");
    formControl.classList.remove("error");
    isVerify.push(true)

}


//
function getFieldName(input) {
    let message ;

    input.id.charAt(0).toUpperCase() + input.id.slice(1) !== "" ?
    message = input.id.charAt(0).toUpperCase() + input.id.slice(1) :
    message = input.className.split(" ")[0].charAt(0).toUpperCase()+ input.className.split(" ")[0].slice(1);
    return message;
}
//
function checkLength(input, min, max) {//Tester la longueur de la valeur  d'un input
    if(input.value.length < min){
        showError(input, getFieldName(input)+" doit contenir au moins "+ min+ " caracteres!");
    }else if(input.value.length > max){
        showError(input, getFieldName(input)+" doit contenir au plus "+ max+ " caracteres!");
    }else{
        showSuccess(input);
    }
}
//
function emailExist(input , message){
    let mail = localStorage.getItem("emailexist");
    let newArr = [];

    for (let i = 0; i < emails.length ; i++) {
        let index = emails[i].getAttribute("value");

        if (mail != null){
            if (index === mail){
                showSuccess(input);
            }else {
                newArr.push(index)
            }
        }else {
            newArr.push(index)
        }
    }

    for (let i = 0; i < newArr.length; i++) {
        let index = newArr[i];
        if (index === input.value){
            showError(input, message);
        }
    }
}

//

function checkRequired(inputArray) {// Tester si les champs ne sont pas vides
    inputArray.forEach(input => {
        if (input.value.trim() === '') {
            showError(input,getFieldName(input) +" est obligatoire");
        }else{
            showSuccess(input);
        }
    });
}

//
function checkEmail(input) {
    const re = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    if (re.test(input.value.trim())) {
        showSuccess(input);
    } else {
        showError(input, "L'email n'est pas valide ");
    }
}



/*service form*/
//Events
function verifServiceForm(form , input) {
    form.addEventListener('submit',(e)=>{
        isVerify = [];
        checkLength(input , 3 , 20);
        emailExist(input,"Ce service existe deja!");
        for (let i = 0; i < isVerify.length; i++) {
            if (isVerify[i]===false) {
                e.preventDefault();//Bloquer la soumission du formulaire
            }
        }
    });
}
//add
if (formService){
    verifServiceForm(formService , nom)
}
//update
if (formServiceUpdate){
    for (let i = 0; i < formServiceUpdate.length; i++) {
        verifServiceForm(formServiceUpdate[i] , nomClass[i])
    }
}



/*specialite form*/
function specialiteForm(form, input , s ) {
    form.addEventListener('submit',(e)=>{
        isVerify = [];
        checkLength(input , 3 , 20);
        emailExist(input,"Cette specialite existe deja!");
        checkRequired([s]);
        for (let i = 0; i < isVerify.length; i++) {
            if (isVerify[i]===false) {
                e.preventDefault();//Bloquer la soumission du formulaire
            }
        }
    });
}
//add
if (formSpecialite){
    specialiteForm(formSpecialite , nom , service)
}
//update
if (formSpecialiteUpdate){
    for (let i = 0; i < formSpecialiteUpdate.length; i++) {
        specialiteForm(formSpecialiteUpdate[i] , nomClass[i] , serviceClass[i])
    }
}

if (formMedcinUpdate || formMedcin){
    function medcinForm(form, input , input1, input2 , input3 , input4 , input5 , input6 , input7 , input8 ,input9 ) {
        form.addEventListener('submit',(e)=>{
            isVerify = [];
            checkLength(input , 3 , 9);
            checkLength(input1 , 2 , 8);
            checkLength(input2 , 2 , 10);
            checkLength(input3 ,  6, 7);
            checkLength(input4 ,  5, 10);
            checkRequired([input5 , input6 ,input7, input8 ]);
            checkEmail(input9);
            emailExist(input9,"Cet email existe deja!");

            for (let i = 0; i < isVerify.length; i++) {
                if (isVerify[i]===false) {
                    e.preventDefault();//Bloquer la soumission du formulaire
                }
            }
        });
    }
}
//add
if (formMedcin){
    medcinForm(
        formMedcin , adresse ,nom, prenom ,
        salaire , password , naissance , embauche ,
        specialite , service ,email
    )
}
//update
if (formMedcinUpdate){
    for (let i = 0; i < formMedcinUpdate.length; i++) {
        medcinForm(
            formMedcinUpdate[i] , adresseClass[i] ,
            nomClass[i], prenomClass[i] , salaireClass[i] , passwordClass[i] , naissanceClass[i] ,
            embaucheClass[i] , specialiteClass[i] , serviceClass[i] , emailClass[i]
        );
    }
}