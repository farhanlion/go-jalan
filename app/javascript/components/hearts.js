function likeHeart(){


	const hearts = document.querySelectorAll(".fa-heart")

	if (hearts){
		hearts.forEach(function(heart){
		console.log(heart)
			heart.addEventListener("click", function(event){
				if 	(heart.className == "fas fa-heart active") {
					heart.className = "fas fa-heart inactive"
				} else {
					heart.className = "fas fa-heart active"
				}
				event.preventDefault();
			})

		})
	}

}

export { likeHeart }
