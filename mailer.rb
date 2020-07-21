require 'mail'

#inside smtp.rb
options = { :address              => "smtp.gmail.com",
            :port                 => 465,
            :domain               => 'your.host.name',
            :user_name            => 'your gmail account username',
            :password             => 'your_password',
            :authentication       => :login,
            :ssl                  => true,
            :openssl_verify_mode  => 'none'
          }

# require 'net/smtp'

# filename = "/tmp/Attachment.pdf"
# file_content = File.read(filename)
# encoded_content = [file_content].pack("m")   # base64

# marker = "AUNIQUEMARKER"

# part1 = <<END_OF_MESSAGE
# From: YourRubyApp <info@yourrubyapp.com>
# To: BestUserEver <pierre.emmanuel.tanguy@gmail.com>
# Subject: Adding attachment to email
# MIME-Version: 1.0
# Content-Type: multipart/mixed; boundary = #{marker}
# --#{marker}
# END_OF_MESSAGE

# part2 = <<END_OF_MESSAGE
# Content-Type: text/html
# Content-Transfer-Encoding:8bit

# A bit of plain text.

# <strong>The beginning of your HTML content.</strong>
# <h1>And some headline, as well.</h1>
# --#{marker}
# END_OF_MESSAGE

# part3 = <<END_OF_MESSAGE
# Content-Type: multipart/mixed; name = "#{filename}"
# Content-Transfer-Encoding:base64
# Content-Disposition: attachment; filename = "#{filename}"

# #{encoded_content}
# --#{marker}--
# END_OF_MESSAGE

# message = part1 + part2 + part3

# begin
#   Net::SMTP.start('your.smtp.server', 25) do |smtp|
#     smtp.send_message message,
#     'info@yourrubyapp.com',
#     'pierre.emmanuel,tanguy@gmail.com'
#   end