// reverse a sentence
// the start of the sentence must be capital
// no other part of the sentence should be capital unless it's a name or place
// the end of the sentence should contain the punctuation marks/s

function reverseSentence(sentence) {

    // first, let's make the first letter of the sentence lower case if it's not an "I"
    if (sentence.charAt(0) !== "I") {
        sentence = sentence.charAt(0).toLowerCase() + sentence.slice(1);
    }

    // next, let's split the sentence into an array of words
    const words = sentence.split(" ");

    // then, let's take out the punctuation marks from the sentence
    const punctuation = sentence.match(/[.,\/#!$%\^&\*;:{}=\-_`~()]/g);
    // now let's remove the punctuation marks from the sentence
    sentence = sentence.replace(/[.,\/#!$%\^&\*;:{}=\-_`~()]/g,"");

    // let's reverse the sentence and join it back together
    const reversedSentence = words.reverse().join(" ");

    // finally, let's make the first letter of the sentence capital and add the punctuation marks back
    return reversedSentence.charAt(0).toUpperCase() + reversedSentence.slice(1) + punctuationArray.join("");

}
