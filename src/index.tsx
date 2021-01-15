import { NativeModules } from 'react-native';

type RnTestModuleType = {
  multiply(a: number, b: number): Promise<number>;
};

const { RnTestModule } = NativeModules;

export default RnTestModule as RnTestModuleType;
