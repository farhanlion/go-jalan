function goBack(){

	const back_btn = document.querySelector(".back-icon")
	if (back_btn) {
		back_btn.addEventListener("click", () => {
			window.history.back();
		})
	}
}

export { goBack }