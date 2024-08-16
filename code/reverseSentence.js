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

// original code fixed by GitHub Copilot

function reverseSentence(sentence) {
    // lowercase the first letter of the sentence if it's not an "I"
    if (sentence.charAt(0) !== "I") {
        sentence = sentence.charAt(0).toLowerCase() + sentence.slice(1);
    }

    // split the sentence
    const sentenceArray = sentence.split(" ");

    // split the punctuation and handle null case
    const punctuationArray = sentence.match(/[.,:;!?]/g) || [];
    // Remove punctuation from the sentence
    sentence = sentence.replace(/[.,:;!?]/g, "");

    // reverse the sentence array and join it together
    const reversedSentenceArray = sentenceArray.reverse();

    // uppercase the first letter of the reversed sentence
    reversedSentenceArray[0] = reversedSentenceArray[0].charAt(0).toUpperCase() + reversedSentenceArray[0].slice(1);

    // join the reversed sentence and add punctuation again
    const reversedSentence = reversedSentenceArray.join(" ") + punctuationArray.join("");

    return reversedSentence;

