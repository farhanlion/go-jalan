import $ from "jquery";
import select2 from "select2";


const improveDropdown = () => {
  $(document).ready(function() {
    $('#review_provider_id').select2();
  });
}

export default improveDropdown;
