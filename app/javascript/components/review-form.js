const form = document.querySelector('form')
const content = document.getElementById("review_content");
const provider = document.getElementById("review_provider_id");
const rating= document.getElementById("review_rating");

function closeForm() {
  document.querySelector("#review-form").style.display = "none";
}

const checkForm = () => {
  const contentFilled = content.value.trim() != "";

  const providerFilled = provider.value != "";

  const ratingFilled = rating.value != ""

  return contentFilled && providerFilled && ratingFilled;
};

  const enableButton = () => {
    document.querySelector(".btn").disabled = false;
  }

form.addEventListener('change', evt => {
  evt.preventDefault();
  if (checkForm()) {
    enableButton();
  }
  else {
    document.querySelector(".btn").disabled = true;
  }
});

provider.onchange = function () {
  if (checkForm()) {
    enableButton();
  }
  else {
    document.querySelector(".btn").disabled = true;
  }
}

rating.onchange = function () {
  if (checkForm()) {
    enableButton();
  }
  else {
    document.querySelector(".btn").disabled = true;
  }
}

const triggerForm = () => {
 document.querySelector(".fa-plus-circle").addEventListener('click', () => {
    document.querySelector("#review_photo_url").click();
  });

  document.querySelector("#review_photo_url").addEventListener('change', preview_image );

  function preview_image(event) {
   var reader = new FileReader();
   reader.onload = function()
   {
    var output = document.getElementById('output_image');
    output.src = reader.result;
   }
   reader.readAsDataURL(event.target.files[0]);
   document.querySelector("#review-form").style.display = "block";
    $(document).ready(function() {
    $('.beautiful-dropdown').select2();
    // document.querySelector(".btn").disabled = true;
  });
  }
};

const close = document.querySelector(".closebtn")
close.addEventListener('click',  () => {
  closeForm();
});

export { triggerForm };





