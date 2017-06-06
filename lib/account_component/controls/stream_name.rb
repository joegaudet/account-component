module AccountComponent
  module Controls
    module StreamName
      module Reply
        def self.example
          "someReplyStream-#{id}"
        end

        def self.id
          Identifier::UUID::Controls::Random.example
        end
      end
    end
  end
end
