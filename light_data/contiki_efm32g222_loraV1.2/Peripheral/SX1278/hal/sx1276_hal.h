/*
 / _____)             _              | |
( (____  _____ ____ _| |_ _____  ____| |__
 \____ \| ___ |    (_   _) ___ |/ ___)  _ \
 _____) ) ____| | | || |_| ____( (___| | | |
(______/|_____)_|_|_| \__)_____)\____)_| |_|
    (C)2013 Semtech

Description: SX1276 driver specific target board functions implementation

License: Revised BSD License, see LICENSE.TXT file include in the project

Maintainer: Miguel Luis and Gregory Cristian
*/
#ifndef __SX1276_ARCH_H__
#define __SX1276_ARCH_H__
#include "stdint.h"
#include "stdbool.h"
#include "sx1276.h"


#ifndef TimerTime_t
typedef uint32_t TimerTime_t;
#endif

#include "contiki.h"

/*!
 * \brief Radio hardware registers initialization definition
 *
 * \remark Can be automatically generated by the SX1276 GUI (not yet implemented)
 */
#define RADIO_INIT_REGISTERS_VALUE                \
{                                                 \
    { MODEM_FSK , REG_LNA                , 0x23 },\
    { MODEM_FSK , REG_RXCONFIG           , 0x1E },\
    { MODEM_FSK , REG_RSSICONFIG         , 0xD2 },\
    { MODEM_FSK , REG_AFCFEI             , 0x01 },\
    { MODEM_FSK , REG_PREAMBLEDETECT     , 0xAA },\
    { MODEM_FSK , REG_OSC                , 0x07 },\
    { MODEM_FSK , REG_SYNCCONFIG         , 0x12 },\
    { MODEM_FSK , REG_SYNCVALUE1         , 0xC1 },\
    { MODEM_FSK , REG_SYNCVALUE2         , 0x94 },\
    { MODEM_FSK , REG_SYNCVALUE3         , 0xC1 },\
    { MODEM_FSK , REG_PACKETCONFIG1      , 0xD8 },\
    { MODEM_FSK , REG_FIFOTHRESH         , 0x8F },\
    { MODEM_FSK , REG_IMAGECAL           , 0x02 },\
    { MODEM_FSK , REG_DIOMAPPING1        , 0x00 },\
    { MODEM_FSK , REG_DIOMAPPING2        , 0x30 },\
    { MODEM_LORA, REG_LR_PAYLOADMAXLENGTH, 0x40 },\
}                                                 \

#define RF_MID_BAND_THRESH                          525000000






typedef struct TimerEvent_s
{
    uint32_t contiki_time_t;    //��ʱʱ��
    struct ctimer Contiki_Callback;   
}TimerEvent_t;

typedef void (*funCallBack)(void *);


void TimerInit( TimerEvent_t *obj, funCallBack fc);
void TimerSetValue( TimerEvent_t *obj, uint32_t value );
void TimerStart( TimerEvent_t *obj );
void TimerStop( TimerEvent_t *obj );


void DelayMs( uint32_t ms );

/*!
 * \brief Initializes the radio I/Os pins interface
 */
void SX1276IoInit( void );

/*!
 * \brief Initializes DIO IRQ handlers
 *
 * \param [IN] irqHandlers Array containing the IRQ callback functions
 */
void SX1276IoIrqInit(void);

void SX1276IoIrqEnable( void);

/*!
 * \brief De-initializes the radio I/Os pins interface. 
 *
 * \remark Useful when going in MCU lowpower modes
 */
//void SX1276IoDeInit( void );

/*!
 * \brief Gets the board PA selection configuration
 *
 * \param [IN] channel Channel frequency in Hz
 * \retval PaSelect RegPaConfig PaSelect value
 */
uint8_t SX1276GetPaSelect( uint32_t channel );

/*!
 * \brief Set the RF Switch I/Os pins in Low Power mode
 *
 * \param [IN] status enable or disable
 */
void SX1276SetAntSwLowPower( bool status );

/*!
 * \brief Initializes the RF Switch I/Os pins interface
 */
void SX1276AntSwInit( void );

/*!
 * \brief De-initializes the RF Switch I/Os pins interface 
 *
 * \remark Needed to decrease the power consumption in MCU lowpower modes
 */
void SX1276AntSwDeInit( void );

/*!
 * \brief Controls the antena switch if necessary.
 *
 * \remark see errata note
 *
 * \param [IN] rxTx [1: Tx, 0: Rx]
 */
void SX1276SetAntSw( uint8_t rxTx );

/*!
 * \brief Checks if the given RF frequency is supported by the hardware
 *
 * \param [IN] frequency RF frequency to be checked
 * \retval isSupported [true: supported, false: unsupported]
 */
bool SX1276CheckRfFrequency( uint32_t frequency );

/*!
 * Radio hardware and global parameters
 */
extern SX1276_t SX1276;


TimerTime_t TimerGetCurrentTime( void );

TimerTime_t TimerGetElapsedTime( TimerTime_t savedTime );


TimerTime_t RtcGetTimerValue( void );



void BoardGetUniqueId( uint8_t *id );


#define SX_REST_HIGH             GPIO_PinOutSet(gpioPortF,    5) ;   //tx
#define SX_REST_LOW              GPIO_PinOutClear(gpioPortF,  5);   //tx

#define  usart_enter 


#endif // __SX1276_ARCH_H__
