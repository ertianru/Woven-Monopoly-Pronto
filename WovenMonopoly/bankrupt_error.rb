class BankruptError < StandardError
    def initialize(msg = 'Player is bankrupt')
        super(msg)
    end
end
