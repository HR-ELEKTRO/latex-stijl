#include <msp430.h>

#define PWM_FREQUENCY 1000 // PWM frequentie in Hz
#define PWM_DUTY_CYCLE 10 // Duty cycle in procent
#define TIMER_CLOCK 1000000 // Timer clock in Hz

void main(void)
{
    // Stop watchdog timer
    WDTCTL = WDTPW + WDTHOLD;

    // Set DCO to 1 MHz
    BCSCTL1 = CALBC1_1MHZ;
    DCOCTL = CALDCO_1MHZ;

    // Configure pin 2.6 (TA0.1) as output
    P2DIR |= BIT6;
    P2SEL |= BIT6;
    P2SEL &= ~BIT7;

    // Configure TimerA0
    TA0CTL = TASSEL_2 + MC_1; // Use SMCLK as clock source, Up mode
    TA0CCTL1 = OUTMOD_7; // Reset/Set output mode

    // Set PWM period
    TA0CCR0 = TIMER_CLOCK / PWM_FREQUENCY - 1;

    // Set initial duty cycle
    TA0CCR1 = (TIMER_CLOCK / PWM_FREQUENCY) * PWM_DUTY_CYCLE / 100;

    // Main loop
    while(1)
    {
        // Add your additional code here
    }
}
