int attempts = 10000, buckets = 10;
double[] r = new double[attempts]; // fully random
for(int i=0;i<attempts;++i) {
  r[i] = random();
}

randomSeed(14); // with seed
double[] r1 = new double[attempts];
for(int i=0;i<attempts;++i) {
  r1[i] = random();
}

randomSeed(14); // with same seed
double[] r2 = new double[attempts];
for(int i=0;i<attempts;++i) {
  r2[i] = random();
}

boolean r1r2TheSame = true;
boolean r1rTheSame = true;
for(int i=0;i<attempts;++i) {
  if(r1[i] != r[i])  r1rTheSame = false;
  if(r1[i] != r2[i]) r1r2TheSame = false;
}

_checkTrue(r1r2TheSame); // random with the same seeds are equal
_checkFalse(r1rTheSame); // no way fully random equal to seeded

int[] b = new int[buckets];
int b1 = new int[buckets];
for(int i=0;i<buckets;++i) {
  b[i] = b1[i] = 0;
}
for(int i=0;i<attempts;++i) {
  var index = int(r[i] * buckets);
  b[i]++;
  var index1 = int(r1[i] * buckets);
  b1[i]++;
}

for(int i=0;i<buckets;++i) {
  if(b[i] == 0) _checkTrue(false); // bad generator
  if(b1[i] == 0) _checkTrue(false); // bad seeded generator
}


randomSeed(14);
var minSample = 30, maxSample = 40;
for(int i=0;i<attempts;++i) {
  var sample = r1[i];
  if(sample < 0 || sample >= 1) _checkTrue(false); // bad random with no args
}
for(int i=0;i<attempts;++i) {
  var sample = random(maxSample);
  if(sample < 0 || sample >= maxSample) _checkTrue(false); // bad random with one arg
}
for(int i=0;i<attempts;++i) {
  var sample = random(minSample, maxSample);
  if(sample < minSample || sample >= maxSample) _checkTrue(false); // bad random with two arg
}
