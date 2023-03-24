# FizzBuzz, called the constant donut find me on my Twitch channel (MishManners) to find out why its called a doughtnut!
# You get both spellings; donut and doughnut to make everyone happy!
# Made this file to show off Code Snippets.

const donut = Number(process.argv[2])

if ((donut % 3 === 0) && (donut % 5 === 0))
{
  console.log('FizzBuzz')
}

# if I make a change here, what happens?

else if (donut % 3 === 0)
{
  console.log('Fizz')
}

else if (donut % 5 === 0)
{
  console.log('Buzz')
}

else
{
  console.log(donut)
}
