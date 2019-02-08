package;

import flixel.FlxGame;
import openfl.display.Sprite;
import js.Browser;

class Main {
    static function main() {
        var button = Browser.document.createButtonElement();
        button.textContent = "Click me!";
        button.onclick = function(event) {
            Browser.alert("Haxe is great");
        }
        Browser.document.body.appendChild(button);

        window.onload = function() {
    document.getElementById("potato-song").play();
}

// Song @ https://goo.gl/YSRXkZ & https://drive.google.com/uc?export=download&id=1dRCqQAtNTgzsioRSoH7qXznYalaOr_le
// Song version 3: https://drive.google.com/uc?export=download&id=13BflK_Ydfg6X_K43yTLiGQUiQ3tLPOYK | edit @ https://goo.gl/isLarB
var char = document.getElementById("char");
var runRight = 'https://drive.google.com/uc?export=download&id=1biXVJA9_lI4es9i4wE497BKGjN1j98wY';
var runLeft = 'https://drive.google.com/uc?export=download&id=1GAJyfg_NRuEDaE61H4x5jTesNsKdduCq';
var idleRight = 'https://drive.google.com/uc?export=download&id=1q0lP-4RUcd3rvM1DKSjTXxbaz3MNwzJJ';
var idleLeft = 'https://drive.google.com/uc?export=download&id=1yRB3nDASmnmS9tH8w2WBq4ebK4cpo9Js';
var attackRight = 'https://drive.google.com/uc?export=download&id=1ig2iROJWOqvdP7oCcgdnQHhUkZyzgLOi';
var attackLeft = 'https://drive.google.com/uc?export=download&id=1-GQu_YAbvoo2nuXC6l4ce5u7QuWuC0t6';
var platform = 'https://drive.google.com/uc?export=download&id=13YqSII2xgH6Sfqg0HxeH1IVybH1BMuIb';
var potato = 'https://drive.google.com/uc?export=download&id=1XZOx4XWZ248kgtiolhdxPlMU8NTRuWbf';
var background = 'https://drive.google.com/uc?export=download&id=1MFI6T0rMaDL8YpdPdC59MzjZYFMuvrUz';
var secretRoom = 'https://drive.google.com/uc?export=download&id=1LFDcMjVFeFUD26anSR0aj2jfVF8ihWGz';

var images = [];
function preloadImages() {
    for (var i = 0; i < arguments.length; i++) {
        images[i] = new Image();
        images[i].src = preloadImages.arguments[i];
    }
}

// Preload all images (improves animation speed)
preloadImages(runRight, runLeft, idleRight, idleLeft, attackRight, attackLeft, platform, potato, background, secretRoom);

var pressed = {};
window.onkeydown = function(e){
    if (pressed[e.which]) return;
    pressed[e.which] = e.timeStamp;
};
    
window.onkeyup = function(e){
    if (!pressed[e.which]) return;
    var duration = (e.timeStamp-pressed[e.which])/1000;
    pressed[e.which] = 0;

    if(guyLeft-30 <= 40 && facing == 1 && e.which == 32 && duration >= .577){
    	count += parseInt(duration/1);
    	detectIfHit();
    }
 }

var guy = document.getElementById('guy');
var container = document.getElementById('container');

// Current position (in px) of the character
var guyLeft = 700;

// (0 = char facing right) & (1 = char facing left)
var facing = 1;

var running = true;

function anim(e){
  if(event.key == "ArrowRight"){
  	facing = 0;
  	charRunRight();
    guyLeft += 4;
    guy.style.left = guyLeft + 'px';
  }

  if(event.key == "ArrowLeft"){
  	facing = 1;
  	charRunLeft();
    guyLeft -= 4;
    guy.style.left = guyLeft + 'px';
  }

  if(e.keyCode == 32 && facing == 0){
		charAttackRight();
  } else if(e.keyCode == 32 && facing == 1){
  		charAttackLeft();   		
  }

}

var guyUpStairs = 94;
function charRunRight(){
	while(running == true){
    	char.src = runRight;
     	running = false;
	}

	if(guyLeft > 1354 && guyLeft != 1440 && facing == 0){
		guy.style.bottom = guyUpStairs + 'px';
		guyUpStairs += 2;
	}

	if(guyLeft >= 1440) {
        guyLeft -= 4;
    }

    if(guyLeft)
  	document.onkeyup = function() {setIdleRight()};
}

function charRunLeft(){
	while(running == true){
   		char.src = runLeft;
   		running = false;
   	}


   	if(guyLeft > 1356 && facing == 1){
   		guy.style.bottom = guyUpStairs + 'px';
   		guyUpStairs -= 2;
   	} 

   	if(guyLeft <= 30) {
        guyLeft += 4;
    }
    document.onkeyup = function() {setIdleLeft()};
}

function charAttackRight(){
	while(attacking == true){
   		char.src = attackRight;
   		attacking = false;
   	}	
   	document.onkeyup = function() {setIdleRight()};
}

function charAttackLeft(){
	while(attacking == true){
   		char.src = attackLeft;
   		attacking = false;
   	}	
   	document.onkeyup = function() {setIdleLeft()};	
}

function setIdleRight(){
	char.src = idleRight;
	running = true;
	attacking = true;
}

function setIdleLeft(){
  	char.src = idleLeft;
  	running = true;
  	attacking = true;
}

var div = document.getElementById('potato-count');
var count = 0;
div.innerHTML += count;
function detectIfHit(){
	setIdleLeft();
	div.innerHTML = "Potatoes: " + count;
}    

// 0 = play, 1 = pause
var audioState = 0;
function toggleSoundImage(img){
   audioState++;
   img.src= img.src=="http://upload.wikimedia.org/wikipedia/commons/thumb/2/21/Speaker_Icon.svg/500px-Speaker_Icon.svg.png" ? "https://cdn2.iconfinder.com/data/icons/picons-essentials/57/music_off-512.png" : "http://upload.wikimedia.org/wikipedia/commons/thumb/2/21/Speaker_Icon.svg/500px-Speaker_Icon.svg.png";
}

function toggleSound(){
	if(audioState % 2 == 1)
		document.getElementById("potato-song").pause();
	else
		document.getElementById("potato-song").play();
}

// If user presses any key, function(s) is fired
document.onkeydown = anim;
	
    }
}