## Price falls
#AAPL
for (i in 1:149) {
  if (data_frame2$AAPL[i] < 0.9*data_frame2$AAPL[1]) {
    print(i);
    break;
  }
}
#GOOGL
for (i in 1:149) {
  if (data_frame2$GOOGL[i] < 0.9*data_frame2$GOOGL[1]) {
    print(i);
    break;
  }
}
#INTC
for (i in 1:149) {
  if (data_frame2$INTC[i] < 0.9*data_frame2$INTC[1]) {
    print(i);
    break;
  }
}
#MSFT
for (i in 1:149) {
  if (data_frame2$MSFT[i] < 0.9*data_frame2$MSFT[1]) {
    print(i);
    break;
  }
}
#NVDA
for (i in 1:149) {
  if (data_frame2$NVDA[i] < 0.9*data_frame2$NVDA[1]) {
    print(i);
    break;
  }
}

## Price rises
#AAPL
for (i in 1:149) {
  if (data_frame2$AAPL[i] > 1.1*data_frame2$AAPL[1]) {
    print(i);
    break;
  }
}
#GOOGL
for (i in 1:149) {
  if (data_frame2$GOOGL[i] > 1.1*data_frame2$GOOGL[1]) {
    print(i);
    break;
  }
}
#INTC
for (i in 1:149) {
  if (data_frame2$INTC[i] > 1.1*data_frame2$INTC[1]) {
    print(i);
    break;
  }
}
#MSFT
for (i in 1:149) {
  if (data_frame2$MSFT[i] > 1.1*data_frame2$MSFT[1]) {
    print(i);
    break;
  }
}
#NVDA
for (i in 1:149) {
  if (data_frame2$NVDA[i] > 1.1*data_frame2$NVDA[1]) {
    print(i);
    break;
  }
}