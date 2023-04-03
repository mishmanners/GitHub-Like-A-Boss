// reverse a sentence
// make the start of the new sentence upper case
// no other upper case in the new sentence
// punctuation at the end of the new sentence

function reverseSentence(sentence) {
    // let's make the first letter of the current sentence upper case
    sentence = sentence.charAt(0).toUpperCase() + sentence.slice(1);
    // let's remove the punctuation at the end of the current sentence
    const punctuation = sentence.match(/[.,\/#!$%\^&\*;:{}=\-_`~()]/g);
    sentence = sentence.replace(/[.,\/#!$%\^&\*;:{}=\-_`~()]/g,"");
    // let's split the current sentence into an array of words
    const words = sentence.split(" ");
    // let's reverse the array of words
    const reversedWords = words.reverse();
    // let's join the array of words into a new sentence
    let newSentence = reversedWords.join(" ");
    // let's add the punctuation at the end of the new sentence
    newSentence = newSentence + punctuation;
    // let's make the first letter of the new sentence lower case
    newSentence = newSentence.charAt(0).toLowerCase() + newSentence.slice(1);
    return newSentence;
}

// reverse a sentence
// we haven't given it any context here!

function reverse(sentence) {
    // let's split the current sentence into an array of words
    const words = sentence.split(" ");
    // let's reverse the array of words
    const reversedWords = words.reverse();
    // let's join the array of words into a new sentence
    let newSentence = reversedWords.join(" ");
    return newSentence;
}

// and this is what we had before we gave Copilot ANY context

function reverse(sentence) {
    return sentence.split(' ').reverse().join(' ');
}
