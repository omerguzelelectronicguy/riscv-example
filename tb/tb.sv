module tb ();
    import riscv_pkg::*;
    //logic [riscv_pkg::XLEN-1:0] addr;
    //logic [riscv_pkg::XLEN-1:0] data;
    logic [riscv_pkg::XLEN-1:0] pc;
    logic                       update;
    logic                       clk;
    logic                       rstn;
    logic [riscv_pkg::XLEN-1:0] instr;
    logic [                4:0] reg_addr;
    logic [riscv_pkg::XLEN-1:0] reg_data;
    logic [riscv_pkg::XLEN-1:0] mem_write_data;
    logic [riscv_pkg::XLEN-1:0] mem_read_addr;
    logic [riscv_pkg::XLEN-1:0] mem_write_addr;
    logic                       mem_write_enable;
    logic                       mem_read_enable;
    logic                       reg_file_write_enable;
    riscv_pkg:: operation_e     operation;

    //test.log ile pc.log karşılaştırması yaparken daha rahat edebilmek için instr, reg_addr ve reg_data'yı ekledik ki program counter(pc) yanında bunları da
    //ekrana basalım ve test.log ile aynı formatta olsun.
    core_model i_core_model (
        .clk(clk),
        .rstn(rstn),
        .pc_o(pc),
        .update_o(update),
        .instr_o(instr),
        .reg_addr_o(reg_addr),
        .reg_data_o(reg_data),
        .memory_read_addr_o(mem_read_addr),
        .memory_write_addr_o(mem_write_addr),
        .memory_write_data_o(mem_write_data),
        .memory_read_enable_o(mem_read_enable),
        .memory_write_enable_o(mem_write_enable),
        .register_file_write_enable_o(reg_file_write_enable),
        .operation_o(operation)
    );

    initial begin
        #20;  //reset sinyalinin 0 olduğu süre kadar bekliyoruz çünkü reset 0 iken program sıfırlanıyor bu nedenle ekrana basmaya gerek yok.
        forever begin

            if(update) begin
                if(pc != 0) begin
                    if(mem_write_enable == 1) begin
                        case(operation)
                            SW: $display("0x%8h (0x%8h) mem 0x%8h 0x%8h", pc, instr, mem_write_addr, mem_write_data);
                            SH: $display("0x%8h (0x%8h) mem 0x%8h 0x%4h", pc, instr, mem_write_addr, mem_write_data);
                            SB: $display("0x%8h (0x%8h) mem 0x%8h 0x%2h", pc, instr, mem_write_addr, mem_write_data);
                            default: ;
                        endcase
                    end
                    else begin
                        if((mem_read_enable == 1) && (reg_addr != 0)) begin
                            if(reg_addr < 10)
                                $display("0x%8h (0x%8h) x%0d  0x%8h mem 0x%8h", pc, instr, reg_addr, reg_data, mem_read_addr);
                            else
                                $display("0x%8h (0x%8h) x%0d 0x%8h mem 0x%8h", pc, instr, reg_addr, reg_data, mem_read_addr);
                        end
                        else if((mem_read_enable == 0)) begin
                            if(reg_addr == 0 || !reg_file_write_enable)
                                $display("0x%8h (0x%8h) ",pc, instr);
                            else begin
                                if(reg_addr < 10)
                                    $display("0x%8h (0x%8h) x%0d  0x%8h",pc, instr, reg_addr, reg_data);
                                else
                                    $display("0x%8h (0x%8h) x%0d 0x%8h",pc, instr, reg_addr, reg_data);
                            end
                        end
                    end
                end
                #2;
            end
        end
    end

    initial begin  //burada clock sinyalini üretiyoruz
        clk = 0;
        forever #1 clk = ~clk;     //her 1 ns de clock sinyali değişiyor
    end

    initial begin
        rstn = 0;
        #20;
        rstn = 1; // 4 birim saniye sonra reset sinyali 1 oluyor ki program çalışmaya başlasın çünkü reset sinyali negatif edge ile çalışıyor
                  // bu nedenle reset sinyali 0 olduğunda program reset halinde oluyor.

        #5000; //5000 birim saniye bekliyoruz

        $finish;
    end

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0,tb);
    end

endmodule
