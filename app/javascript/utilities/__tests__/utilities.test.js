import { getCSRF, firstCharCap } from "../utilities";

describe("getCSRF", () => {
  it("is defined correctly", () => {
    let element = document.querySelector('meta[name="csrf-token"]');
    let csrfToken = element.getAttribute('content');

    expect(getCSRF).toBeDefined();
    expect(getCSRF()).toBe(csrfToken);
  });
});

describe("firstCharCap", () => {
  let exampleStrings = {
    singleWord: "test",
    withSpaces: "lorem ipsum",
    allCaps: "DOES THIS WORK?",
    alreadyCorrect: "Perfect"
  };

  it("is defined correctly", () => {
    expect(firstCharCap).toBeDefined();
  });

  it("corrects a single word", () => {
    expect(firstCharCap(exampleStrings.singleWord)).toBe("Test");
  });

  it("corrects phrases", () => {
    expect(firstCharCap(exampleStrings.withSpaces)).toBe("Lorem ipsum");
  });

  it("works with all caps", () => {
    expect(firstCharCap(exampleStrings.allCaps)).toBe(exampleStrings.allCaps);
  });

  it("doesn't effect a phrase that's already correct", () => {
    expect(firstCharCap(exampleStrings.alreadyCorrect)).toBe(exampleStrings.alreadyCorrect);
  });
});
