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
  });
  }
};

export { triggerForm };





