	function seeMore(){
		const see_more = document.querySelector("#see-more")
		const description = document.querySelector(".provider-description")
        if (see_more) {

		see_more.addEventListener("click", () => {
			if (description.style.display == "-webkit-box") {
		   console.log(description.style.display)
			description.style.display ="block"
			description.style.height="100%"
			see_more.innerText = "See less"
			} else {

			description.style.display="-webkit-box"
			description.style.height="65px"
			see_more.innerText = "See More"
			}

			})

	}

} 
export { seeMore };