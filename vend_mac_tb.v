module vend_mac_tb;

reg [1:0] selection;
reg clk;
reg reset;
reg randomize;
reg [7:0] amount;

wire [39:0] item;
wire [7:0] price;
wire [7:0] balance;

vend_mac uut (
    .selection(selection),
    .clk(clk),
    .reset(reset),
    .randomize(randomize),
    .amount(amount),
    .item(item),
    .price(price),
    .balance(balance)
);

// Clock generation
initial
begin
    clk = 0;
    forever #5 clk = ~clk;
end

// Test sequence
initial
begin
    reset = 1;
    selection = 2'b00;
    randomize = 0;
    amount = 8'd0;

    #20;
    reset = 0;

    // Test 1
    selection = 2'b01;
    amount = 8'd20;
    randomize = 0;
    #20;

    // Test 2
    selection = 2'b11;
    amount = 8'd10;
    randomize = 0;
    #20;

    // Test 3
    randomize = 1;
    amount = 8'd30;
    #10;
    randomize = 0;
    #20;

    // Test 4
    randomize = 1;
    amount = 8'd5;
    #10;
    randomize = 0;
    #20;

    // Test 5
    repeat (5)
    begin
        randomize = 1;
        amount = $urandom % 40;
        #10;
        randomize = 0;
        #20;
    end

    // Test 6
    reset = 1;
    #10;
    reset = 0;
    #20;

    $finish;
end

initial
begin
    $display("Time\tItem\tPrice\tBalance");
    $monitor("%0t\t%s\t%0d\t%0d", $time, item, price, balance);
end

endmodule
