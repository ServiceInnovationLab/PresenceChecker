import { getCSRF, firstCharCap } from "../../../app/javascript/utilities/utilities";

describe("getCSRF", () => {
  xit("is defined correctly", () => {
    // Currently, this doesn't have a good way to be tested as JavaScript
    // doesn't have a good way to render that Rails view. Not sure what the
    // implementation should look like.
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
