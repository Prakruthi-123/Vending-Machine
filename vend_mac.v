module vend_mac(
    input  logic [1:0] selection,
    input  logic       clk,
    input  logic       reset,
    input  logic       randomize,
    input  logic [7:0] amount,

    output logic [39:0] item,
    output logic [7:0]  price,
    output logic [7:0]  balance
);

parameter CHIPS      = "chips";
parameter SODA       = "soda ";
parameter COKE       = "coke ";
parameter CHOCOLATE  = "choco";

parameter PRICE_CHIPS      = 8'd10;
parameter PRICE_SODA       = 8'd15;
parameter PRICE_COKE       = 8'd20;
parameter PRICE_CHOCOLATE  = 8'd25;

parameter SEL_CHIPS      = 2'b00;
parameter SEL_SODA       = 2'b01;
parameter SEL_COKE       = 2'b10;
parameter SEL_CHOCOLATE  = 2'b11;

logic [1:0] current_selection;

always @(posedge clk or posedge reset)
begin
    if (reset)
    begin
        item <= "     ";
        price <= 8'd0;
        balance <= 8'd0;
        current_selection <= 2'b00;
    end
    else
    begin
        if (randomize)
            current_selection <= $urandom % 4;
        else
            current_selection <= selection;

        case (current_selection)

            SEL_CHIPS:
            begin
                item <= CHIPS;
                price <= PRICE_CHIPS;
            end

            SEL_SODA:
            begin
                item <= SODA;
                price <= PRICE_SODA;
            end

            SEL_COKE:
            begin
                item <= COKE;
                price <= PRICE_COKE;
            end

            SEL_CHOCOLATE:
            begin
                item <= CHOCOLATE;
                price <= PRICE_CHOCOLATE;
            end

            default:
            begin
                item <= "     ";
                price <= 8'd0;
            end

        endcase

        if (amount >= price)
            balance <= amount - price;
        else
            balance <= amount;
    end
end

endmodule
