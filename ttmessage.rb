require 'resque'

module TTQ

  class TTMessage
    @queue = :umovsync

    def self.perform(message)
      MessageProcessor.process(message)
    end

  end

  class MessageProcessor

    def self.processor_of message
      case type_of(message)
        when :loc then return LocalMessageProcessor.new
        when :age then return AgentMessageProcessor.new
      end
      raise "Unknown Message Type: #{message_type}"
    end

    def self.process message
      processor_of(message).process message
    end

    def self.type_of message
      raise "Invalid message. It must have at least 3 characters." if message.length < 3
      message[0,3].to_sym
    end

  end

  class LocalMessageProcessor
    def process message
      puts "LocalMessageProcessor has processed: #{message}"
    end
  end

  class AgentMessageProcessor
    def process message
      puts "AgentMessageProcessor has processed: #{message}"
    end
  end

end

