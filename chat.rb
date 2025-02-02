# Write your solution here!
require "openai"
require "dotenv/load"

client = OpenAI::Client.new(access_token: ENV.fetch("OPENAI_KEY"))

# Prepare an Array of previous messages
message_list = [
  {
    "role" => "system",
    "content" => "You are a helpful assistant."
  }
]

user_input = ""

while user_input != "bye"
  if user_input == ""
  puts "Hello! How can I help you today?"

  puts "-" * 50
  end

  user_input = gets.chomp

  if user_input != "bye"
    message_list.push({ "role" => "user", "content" => user_input })


    # Call the API to get the next message from GPT
    api_response = client.chat(
      parameters: {
        model: "gpt-3.5-turbo",
        messages: message_list
      }
    )

  choices = api_response.fetch("choices")

  message = choices.at(0).fetch("message")

  gpt_response = message.fetch("content")

  puts "-" * 50

  puts gpt_response

  puts "-" * 50

  message_list.push({ "role" => "assistant", "content" => gpt_response })
    end
  end

puts "Goodbye! Have a great day!"
