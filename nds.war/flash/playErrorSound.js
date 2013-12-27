playErrorSound = {};
FABridge.addInitializationCallback("b_playErrorSound", playErrorSoundReady);
function playErrorSoundReady() {
	b_playErrorSound_root = FABridge["b_playErrorSound"].root();
	playErrorSound.getErrorSound = function () {
		return b_playErrorSound_root.getErrorSound();
	};
	playErrorSound.setStr = function(argString) {
		b_playErrorSound_root.setStr(argString);
	};

}
