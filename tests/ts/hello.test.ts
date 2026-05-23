import { expect, test } from 'vitest';
import { hello } from '../../src/ts/index';

test('hello function', () => {
  expect(hello('Agent')).toBe('Hello, Agent!');
});
