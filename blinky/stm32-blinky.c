#include <libopencm3/stm32/rcc.h>
#include <libopencm3/stm32/flash.h>
#include <libopencm3/stm32/gpio.h>
#include <libopencm3/cm3/nvic.h>
#include <libopencm3/cm3/systick.h>
#include <libopencm3/cm3/scs.h>
#include <libopencm3/stm32/timer.h>

volatile uint32_t systicks = 0;
void sys_tick_handler(void)
{
	systicks++;
}

int main(void) {
    rcc_periph_clock_enable(RCC_GPIOC);
    gpio_set_mode(GPIOC, GPIO_MODE_OUTPUT_2_MHZ, GPIO_CNF_OUTPUT_PUSHPULL, GPIO13);
	systick_set_clocksource(STK_CSR_CLKSOURCE);
	systick_set_reload(8999);
	systick_interrupt_enable();
	systick_counter_enable();
    uint32_t  onTime = 25;
    uint32_t  offTime = 1000 - onTime;
    uint32_t  duration = onTime;
    uint32_t  ticks = systicks;
    int flashes = 4;
    while(1) {
        if (systicks > ticks) {
        	if (duration == onTime) {
            	duration = offTime;
        		gpio_set(GPIOC, GPIO13);
        	}
        	else {
            	duration = onTime;
        		gpio_clear(GPIOC, GPIO13);
        	}
        	ticks = systicks+duration;
        }
    }
}
